require 'spec_helper'
require 'calculator'

RSpec.describe Calculator do
  describe "#calculate_frame_scores" do
    let(:rolls) { ["X"] }
    # let(:subject) { Calculator.calculate_frame_scores(rolls) }
    let(:frame_calculations) { Class.new { extend Calculator }.calculate_frame_scores(rolls) }

    context "given roll(s) for the first frame" do
      context "the first roll was a strike" do
        it "should return nil without 2 proceding valid rolls" do
          expect(frame_calculations).to eq([nil])
        end
      end
      context "both rolls are numbers without a spare" do
        let(:rolls) { [1,5] }
        it "should return the value of both numbers added together" do
          expect(frame_calculations).to eq([6])
        end
      end
    
      context "the first 2 rolls are a spare" do
        let(:rolls) { [1,"/"] }
        it "should return nil since you the next rolls isnt available yet" do
          expect(frame_calculations).to eq([nil])
        end
      end
    end

    context "several completed rolls are given" do
      context "there are only 3 frames, all strikes" do
      let(:rolls) { ["X", "X", "X"]}
        it "should return a valid score for only the first strike" do
          expect(frame_calculations).to eq([30, nil, nil])
        end
      end

      context "a strike is given with necessary preceding rolls" do
        let(:rolls) { ["X",1,"/",5] }
        it "should calculate the score for the strike frame " do
          expect(frame_calculations).to eq([20,15,nil])
        end
      end

      context "there are 3 strikes in a row with only one roll after that so far" do
        let(:rolls) { ["X","X","X",4] }
        it "should return score for first and second strikes but nil for the third strike" do
          expect(frame_calculations).to eq([30, 24, nil, nil])
        end
      end
    end

    context "rolls for all 10 frames have started" do
      let(:rolls) { [3,5,1,3,"X","X",3,"/",3,5,2,"/",2,1,0,4,"X","X",1] }
      let(:frame_calculations) { Class.new { extend Calculator }.calculate_frame_scores(rolls) }

      context "when there are no missing rolls and the 10th frame includes 1+ strike" do
        it "should give valid scores for every frame" do
          expect(frame_calculations).to eq([8,4,23,20,13,8,12,3,4,21])
        end
      end

      context "when the final frame has started but isn't complete" do
        it "gives all frames scores and leaves nil for the unfinished final frame" do
          rolls.pop
          expect(frame_calculations).to eq([8,4,23,20,13,8,12,3,4,nil])
        end
      end

      context "when the final frame doesn't include a strike or spare" do
        let(:rolls) { [3,5,1,3,"X","X",3,"/",3,5,2,"/",2,1,0,4,5,3] }
        it "calculates the last frame correctly without error" do
          expect(frame_calculations).to eq([8,4,23,20,13,8,12,3,4,8])
        end
      end
    end

    context "invalid value(s) for rolls were submitted" do
      let(:rolls) { [1, 3, 11] }
      it "throws an error" do
        expect { frame_calculations }.to raise_error(ArgumentError)
      end
    end
  end
end