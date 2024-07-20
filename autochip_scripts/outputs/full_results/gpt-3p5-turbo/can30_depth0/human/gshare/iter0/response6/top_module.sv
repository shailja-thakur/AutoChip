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
parameter NUM_ENTRIES = 128;
parameter INDEX_BITS = 7;
parameter PC_BITS = 7;
parameter HISTORY_BITS = 7;
parameter COUNTER_BITS = 2;

// Define registers and wires
reg [HISTORY_BITS-1:0] history_reg;
reg [INDEX_BITS-1:0] index;
reg [COUNTER_BITS-1:0] counter;

wire [COUNTER_BITS-1:0] counter_out;
wire predict_taken;
wire [INDEX_BITS-1:0] predict_index;

// Predict stage
wire [PC_BITS-1:0] predict_pc_reg;
reg predict_taken_reg;
reg [PC_BITS-1:0] predict_pc_temp;
reg [HISTORY_BITS-1:0] predict_history_reg;

assign predict_taken = predict_taken_reg;
assign predict_index = index;

reg predict_enable;
reg [INDEX_BITS-1:0] predict_index_temp;
wire [COUNTER_BITS-1:0] predict_counter_temp;

reg training_enable;
reg [INDEX_BITS-1:0] training_index_temp;
wire [COUNTER_BITS-1:0] training_counter_temp;

reg predict_ready;
reg training_ready;

// Training stage
wire [PC_BITS-1:0] train_pc_reg;
reg [PC_BITS-1:0] train_pc_temp;
reg [HISTORY_BITS-1:0] train_history_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        history_reg <= 0;
        counter <= 0;
    end else begin
        history_reg <= {history_reg[HISTORY_BITS-2:0], predict_taken_reg};
        counter <= counter_out;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_taken_reg <= 0;
        predict_pc_reg <= 0;
        predict_history_reg <= 0;
    end else begin
        predict_taken_reg <= predict_taken;
        predict_pc_reg <= predict_pc_temp;
        predict_history_reg <= history_reg;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        train_pc_temp <= 0;
        train_history_reg <= 0;
    end else if (training_enable) begin
        train_pc_temp <= train_pc;
        train_history_reg <= train_history;
    end
end

assign predict_pc_temp = predict_pc;
assign training_enable = train_valid;
assign predict_enable = predict_valid;
assign predict_counter_temp = counter;
assign training_counter_temp = counter;

assign predict_ready = 1;
assign training_ready = 1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        index <= 0;
        predict_taken_reg <= 0;
        predict_history_reg <= 0;
    end else if (predict_enable) begin
        if (predict_ready) begin
            index <= predict_index_temp;
            predict_taken_reg <= predict_counter_temp[1];
            predict_history_reg <= history_reg;
        end
    end else if (training_enable) begin
        if (training_ready) begin
            index <= training_index_temp;
            predict_taken_reg <= train_taken;
            predict_history_reg <= train_history_reg;
        end
    end
end

counter_module counter_inst(
    .clk(clk),
    .areset(areset),
    .enable(predict_enable),
    .index(predict_index),
    .counter_out(counter_out)
);

assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_reg;

endmodule
module counter_module(
    input clk,
    input areset,
    input enable,
    input [INDEX_BITS-1:0] index,
    output [COUNTER_BITS-1:0] counter_out
);

reg [COUNTER_BITS-1:0] counter_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        counter_reg <= 0;
    end else if (enable) begin
        case (counter_reg)
            0: counter_reg <= 1;
            1: counter_reg <= (index == 0) ? (enable ? 1 : 0) : (enable ? 2 : 3);
            2: counter_reg <= (index == 0) ? (enable ? 3 : 2) : (enable ? 3 : 2);
            3: counter_reg <= (index == 0) ? (enable ? 3 : 2) : (enable ? 3 : 2);
            default: counter_reg <= 0;
        endcase
    end
end

assign counter_out = counter_reg;

endmodule
