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

// Define parameters
parameter INDEX_WIDTH = 7;
parameter GHISTORY_WIDTH = 7;
parameter PHT_SIZE = 128;
parameter PREDICT_HISTORY_WIDTH = 2;

// Define registers and wires
reg [INDEX_WIDTH-1:0] index;
reg [GHISTORY_WIDTH-1:0] global_history;
reg [GHISTORY_WIDTH-1:0] branch_history_register;
reg [PREDICT_HISTORY_WIDTH-1:0] predict_history_reg;
reg predict_taken_reg;
reg [GHISTORY_WIDTH-1:0] updated_branch_history_register;
reg [PREDICT_HISTORY_WIDTH-1:0] updated_predict_history_reg;

// Initialize registers
always @(posedge clk or negedge areset) begin
    if (!areset) begin
        predict_history_reg <= 0;
    end else begin
        predict_history_reg <= updated_predict_history_reg;
    end
end

always @(posedge clk or negedge areset) begin
    if (!areset) begin
        branch_history_register <= 0;
    end else begin
        branch_history_register <= updated_branch_history_register;
    end
end

// Hashing of pc and global history into index
always @* begin
    index = {predict_pc[6:0], global_history[6:0]} ^ ((INDEX_WIDTH > 7) ? 7'b0110101 : 7'b1010101);
end

// Prediction logic
always @* begin
    predict_taken_reg = (predict_history_reg >= 2'b10);
end

always @* begin
    predict_taken = predict_taken_reg;
    predict_history = predict_history_reg;
end

// Training logic
always @(posedge clk) begin
    if (train_valid) begin
        if (train_mispredicted) begin
            updated_branch_history_register <= train_history;
            updated_predict_history_reg <= {train_history[5:1], train_taken};
        end else begin
            updated_branch_history_register <= {branch_history_register[5:1], train_taken};
            updated_predict_history_reg <= {predict_history_reg[1:0], train_taken};
        end
    end else begin
        updated_branch_history_register <= branch_history_register;
        updated_predict_history_reg <= predict_history_reg;
    end
end

endmodule
