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

// Define the parameters
parameter INDEX_SIZE = 128;
parameter HISTORY_SIZE = 7;
parameter COUNTER_SIZE = 2;

// Define the types
typedef logic [HISTORY_SIZE-1:0] history_register_t;
typedef logic [COUNTER_SIZE-1:0] counter_t;

// Define the module inputs
input predict_valid;
input [6:0] predict_pc;

// Define the module outputs
output predict_taken;
output [6:0] predict_history;

// Define the module inputs for training
input train_valid;
input train_taken;
input train_mispredicted;
input [6:0] train_history;
input [6:0] train_pc;

// Define the registers
reg [HISTORY_SIZE-1:0] branch_history_register;
reg [INDEX_SIZE-1:0] counter_index_register;

// Define the branch history table
reg [COUNTER_SIZE-1:0] pht [INDEX_SIZE-1:0];

// Define the internal signals
wire [INDEX_SIZE-1:0] pht_index;

// Synchronous reset
always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history_register <= 0;
        counter_index_register <= 0;
        pht <= 0;
    end else begin
        branch_history_register <= {train_history, train_taken};
        counter_index_register <= {predict_pc[HISTORY_SIZE-1:0], branch_history_register};
    end
end

// Assign the prediction outputs
assign pht_index = counter_index_register ^ branch_history_register;
assign predict_taken = pht[pht_index] > 1;
assign predict_history = branch_history_register;

// Training logic
always @(posedge clk) begin
    if (train_valid) begin
        pht[pht_index] <= train_mispredicted ? (pht[pht_index] == 0 ? 0 : pht[pht_index] - 1) : (pht[pht_index] == 3 ? 3 : pht[pht_index] + 1);
    end
end

endmodule
