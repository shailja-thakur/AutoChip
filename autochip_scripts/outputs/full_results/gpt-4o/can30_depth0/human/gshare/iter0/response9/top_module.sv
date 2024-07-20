module top_module(
	input clk,
	input areset,

	input predict_valid,
	input [6:0] predict_pc,
	output reg predict_taken,
	output reg [6:0] predict_history,

	input train_valid,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history,
	input [6:0] train_pc
);

    // 128-entry table of two-bit saturating counters
    reg [1:0] PHT [0:127];
    
    // 7-bit global branch history register
    reg [6:0] GHR;

    // Initialize PHT and GHR
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            GHR <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly taken
            end
        end
    end

    // Compute the index using predict_pc and GHR
    wire [6:0] predict_index = predict_pc ^ GHR;

    // Update output for prediction
    always @(*) begin
        if (predict_valid) begin
            predict_history = GHR;
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken = 0; // Not taken
                2'b10, 2'b11: predict_taken = 1; // Taken
                default: predict_taken = 0;      // Safety
            endcase
        end
    end

    // Training logic
    always @(posedge clk) begin
        if (train_valid) begin
            if (train_taken) begin
                if (PHT[train_pc ^ train_history] != 2'b11)
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] + 1;
            end else begin
                if (PHT[train_pc ^ train_history] != 2'b00)
                    PHT[train_pc ^ train_history] <= PHT[train_pc ^ train_history] - 1;
            end

            if (train_mispredicted) begin
                // Recover GHR to the state immediately after the mispredicted branch completes execution
                GHR <= {train_history[5:0], train_taken};
            end else begin
                // Update GHR for the next prediction
                if (predict_valid && !train_valid) begin
                    GHR <= {GHR[5:0], predict_taken};
                end
            end
        end else if (predict_valid) begin
            // Update GHR for the next prediction
            GHR <= {GHR[5:0], predict_taken};
        end
    end

endmodule
