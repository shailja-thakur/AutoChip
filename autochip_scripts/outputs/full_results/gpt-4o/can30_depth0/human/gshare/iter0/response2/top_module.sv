module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    reg [1:0] PHT [0:127]; // 128-entry table of two-bit saturating counters
    reg [6:0] global_history; // 7-bit global branch history register
    reg [1:0] counter; // Two-bit saturating counter for prediction

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            // Resetting the PHT
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; // Weakly taken default state for all entries
            end
        end
        else begin
            if (train_valid) begin
                // Update the PHT based on actual branch outcome
                counter = PHT[train_pc ^ train_history];
                if (train_taken) begin
                    if (counter != 2'b11) counter = counter + 1;
                end else begin
                    if (counter != 2'b00) counter = counter - 1;
                end
                PHT[train_pc ^ train_history] <= counter;
                
                // Recover global history register if it is a misprediction
                if (train_mispredicted) begin
                    global_history <= {global_history[5:0], train_taken};
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Combinational logic for prediction
    assign predict_history = global_history;
    assign counter = PHT[predict_pc ^ global_history];
    assign predict_taken = counter[1];
    
endmodule
