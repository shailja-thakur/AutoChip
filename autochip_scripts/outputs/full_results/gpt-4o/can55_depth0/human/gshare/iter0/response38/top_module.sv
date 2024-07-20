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

    reg [6:0] global_history;
    reg [1:0] saturating_counters [0:127];

    integer i;

    // Asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                saturating_counters[i] <= 2'b01; // Initializing to weakly taken state
            end
        end 
        else if (train_valid) begin
            integer index;
            index = train_pc ^ train_history;
            if (train_taken) begin
                if (saturating_counters[index] < 2'b11)
                    saturating_counters[index] <= saturating_counters[index] + 2'b01;
            end else begin
                if (saturating_counters[index] > 2'b00)
                    saturating_counters[index] <= saturating_counters[index] - 2'b01;
            end

            // If the branch was mispredicted, restore the branch history register
            if (train_mispredicted)
                global_history <= train_history;
            else
                global_history <= {global_history[5:0], train_taken};
        end else if (predict_valid) begin
            predict_history <= global_history;
            integer index;
            index = predict_pc ^ global_history;
            predict_taken <= saturating_counters[index] >= 2'b10;
            global_history <= {global_history[5:0], predict_taken};  // Update history based on prediction
        end
    end

endmodule
