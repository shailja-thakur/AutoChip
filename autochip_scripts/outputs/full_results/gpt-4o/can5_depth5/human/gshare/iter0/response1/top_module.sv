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
    reg [1:0] PHT[127:0];
    // Global branch history register (7-bit)
    reg [6:0] global_history;
    // Temporary register to store history for next prediction
    reg [6:0] next_history;

    integer i;

    // Asynchronous reset
    always @(posedge areset or posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly not taken state
            end
        end else if (clk) begin
            if (predict_valid) begin
                // Update the global history register at the next positive clock edge
                global_history <= next_history;
            end

            if (train_valid) begin
                // Hash with XOR to generate index
                reg [6:0] index;
                index = train_pc ^ train_history;
                
                // Update the PHT entry with actual outcome
                if (train_taken) begin
                    if (PHT[index] < 2'b11) begin
                        PHT[index] <= PHT[index] + 1;
                    end
                end else begin
                    if (PHT[index] > 2'b00) begin
                        PHT[index] <= PHT[index] - 1;
                    end
                end
                
                // Recover global history register if mispredicted
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end
        end
    end

    always @* begin
        if (predict_valid) begin
            // Hash with XOR to generate index
            reg [6:0] index;
            index = predict_pc ^ global_history;
            
            // Get prediction
            predict_taken = (PHT[index] >= 2'b10);
            predict_history = global_history;
            
            // Prepare next history in case of prediction
            next_history = {global_history[5:0], predict_taken};
        end else begin
            predict_taken = 0;
            predict_history = global_history;
            next_history = global_history;
        end
    end

endmodule
