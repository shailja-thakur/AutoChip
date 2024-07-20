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

    reg [1:0] PHT [127:0]; // 128-entry Pattern History Table with 2-bit counters
    reg [6:0] global_history; // 7-bit global branch history register

    // Initialize all the entries in PHT to weakly not-taken (01)
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01;
        end
    end

    // Combinational logic for prediction
    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history;
            predict_taken = PHT[predict_pc ^ global_history][1]; // MSB of 2-bit counter determines taken or not
        end else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Sequential logic for updating PHT and history
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0; // Reset global history
            // Reset all PHT entries to weakly not-taken (01)
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                // Calculate the index
                integer index = train_pc ^ train_history;

                // Update the PHT entry based on actual branch outcome
                if (train_taken) begin
                    if (PHT[index] < 2'b11)
                        PHT[index] <= PHT[index] + 2'b01;
                end else begin
                    if (PHT[index] > 2'b00)
                        PHT[index] <= PHT[index] - 2'b01;
                end

                if (train_mispredicted) begin
                    // Recover the global branch history register to the state immediately after the mispredicting branch
                    global_history <= train_history;
                end
            end

            // Update global history and PHT entry for predictable branch
            if (predict_valid && !(train_valid && train_mispredicted)) begin
                global_history <= {global_history[5:0], predict_taken}; // Shift history register left and add new prediction result
            end
        end
    end

endmodule
