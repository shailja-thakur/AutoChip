module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // The PHT is a 128-entry table of two-bit saturating counters.
    logic [1:0] [6:0] pt [127:0];

    // The global history register is a 7-bit register.
    logic [6:0] gh;

    // The prediction logic takes the pc and global history register as input and produces the predicted branch direction and state of the branch history register used to make the prediction.
    logic predict_taken;
    logic [6:0] predict_history;
    always @(posedge clk) begin
        if (areset) begin
            pt <= 2'b01;
            gh <= 0;
        end else begin
            if (predict_valid) begin
                predict_taken = pt[predict_pc];
                predict_history = gh;
            end
        end
    end

    // The training logic takes the pc, branch history register value, actual branch outcome, and whether the branch was a misprediction as input and updates the PHT to train the branch predictor to predict this branch more accurately next time.
    always @(posedge clk) begin
        if (areset) begin
            pt <= 2'b01;
            gh <= 0;
        end else begin
            if (train_valid) begin
                pt[train_pc] <= pt[train_pc] + (train_taken ? 1 : -1);
                if (train_mispredicted) begin
                    gh <= gh + 1;
                end
            end
        end
    end

    // The output signals are the predicted branch direction and state of the branch history register used to make the prediction.
    output predict_taken;
    output [6:0] predict_history;

endmodule