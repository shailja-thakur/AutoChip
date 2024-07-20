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
    reg [6:0] global_history;
    reg [6:0] predict_index;
    reg [1:0] predict_state;
    reg [6:0] train_index;
    reg [1:0] train_state;
    
    reg [1:0] pattern_history_table [0:127];
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            predict_index <= 0;
            predict_state <= 0;
            train_index <= 0;
            train_state <= 0;
        end else begin
            if (predict_valid) begin
                predict_index <= predict_pc ^ global_history;
                predict_state <= pattern_history_table[predict_index];
            end
            
            if (train_valid) begin
                train_index <= train_pc ^ train_history;
                train_state <= pattern_history_table[train_index];
                if (train_mispredicted) begin
                    pattern_history_table[train_index] <= (train_state == 2'b00 || train_state == 2'b01) ? 2'b00 : 2'b11;
                    global_history <= train_history;
                end else begin
                    pattern_history_table[train_index] <= (train_state == 2'b00 || train_state == 2'b01) ? 2'b01 : 2'b10;
                end
            end
        end
    end
    
    assign predict_taken = (predict_state == 2'b01 || predict_state == 2'b11) ? 1'b1 : 1'b0;
    assign predict_history = global_history;
    
endmodule
