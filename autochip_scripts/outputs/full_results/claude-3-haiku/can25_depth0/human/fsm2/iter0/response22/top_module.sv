module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Define the states
localparam OFF = 1'b0;
localparam ON = 1'b1;

// State register
reg state;

// Next state logic
always @(*) begin
    case (state)
        OFF: begin
            if (j == 1'b0) begin
                state <= OFF;
            end else if (j == 1'b1) begin
                state <= ON;
            end
        end
        ON: begin
            if (k == 1'b0) begin
                state <= ON;
            end else if (k == 1'b1) begin
                state <= OFF;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        OFF: out = 1'b0;
        ON: out = 1'b1;
    endcase
end

// Asynchronous reset
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= OFF;
    end else begin
        state <= state;
    end
end

endmodule
