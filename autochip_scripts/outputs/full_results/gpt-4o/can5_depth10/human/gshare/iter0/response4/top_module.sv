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

    reg [1:0] PHT [127:0]; // Pattern History Table with 128 2-bit counters
    reg [6:0] global_history; // 7-bit Global History Register
    
    // Initialize the PHT
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b00; // Initialize counters to Strongly Not Taken
        end
    end

    wire [6:0] predict_index = predict_pc ^ global_history;
    wire [6:0] train_index = train_pc ^ train_history;
    reg [1:0] predict_counter;

    always @(*) begin
        if (predict_valid) begin
            predict_history = global_history; 
            predict_counter = PHT[predict_index];
            predict_taken = predict_counter[1]; // Predict taken if counter state is 2'b10 or 2'b11
        end
        else begin
            predict_history = 7'b0;
            predict_taken = 1'b0;
        end
    end
  
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end
        else begin
            if (train_valid) begin
                global_history <= train_mispredicted ? train_history : (global_history << 1) | train_taken;
                case (PHT[train_index])
                    2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00;
                    2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00;
                    2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01;
                    2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10;
                endcase
            end
            else if (predict_valid) begin
                global_history <= (global_history << 1) | predict_taken;
            end
        end
    end
    
endmodule
