module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

// Define states 
localparam [1:0] STATE_0 = 2'b00;
localparam [1:0] STATE_1 = 2'b01;
localparam [1:0] STATE_2 = 2'b10;
localparam [1:0] STATE_3 = 2'b11;

// Define current state signal
reg [1:0] current_state;

// On asynchronous reset, set current state to STATE_1
always @(posedge clk or posedge areset) begin
    if (areset)
        current_state <= STATE_1;
end

// Update state based on valid and taken signals
always @(posedge clk) begin
    if (train_valid) begin
        if (train_taken && current_state < STATE_3)
            current_state <= current_state + 1;
        else if (!train_taken && current_state > STATE_0)
            current_state <= current_state - 1;
    end
end

// Assign current state to output
assign state = current_state;

endmodule
