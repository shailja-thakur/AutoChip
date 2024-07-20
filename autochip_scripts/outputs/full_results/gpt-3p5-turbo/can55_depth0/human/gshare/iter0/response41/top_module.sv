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
    
    // Constants
    parameter INDEX_BITS = 7;
    parameter GLOBAL_HISTORY_BITS = 7;
    parameter PHT_SIZE = 128;
    
    // Registers
    reg [INDEX_BITS-1:0] index;
    reg [GLOBAL_HISTORY_BITS-1:0] global_history;
    reg [1:0] pht[PHT_SIZE-1:0];
    
    // Wires
    wire [1:0] pht_data;
    wire predict_valid_next;
    wire train_valid_next;
    
    // Combinational Logic
    assign pht_data = pht[index];
    
    assign predict_valid_next = (predict_valid & ~train_valid) | (predict_valid & (predict_pc != train_pc));
    
    assign train_valid_next = (train_valid & ~predict_valid) | (train_valid & (predict_pc != train_pc));
    
    assign predict_taken = pht_data[1];
    
    assign predict_history = global_history;
    
    // Sequential Logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            index <= 0;
            global_history <= 0;
            for (i = 0; i < PHT_SIZE; i = i + 1) begin
                pht[i] <= 2'b0;
            end
        end else begin
            index <= predict_pc ^ global_history;
            if (predict_valid) begin
                global_history <= {global_history[GLOBAL_HISTORY_BITS-2:0], predict_taken};
            end else if (train_valid) begin
                global_history <= {global_history[GLOBAL_HISTORY_BITS-2:0], train_taken};
                pht[index] <= pht_data + (train_taken ? 1 : -1);
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end
        end
    end
    
endmodule
