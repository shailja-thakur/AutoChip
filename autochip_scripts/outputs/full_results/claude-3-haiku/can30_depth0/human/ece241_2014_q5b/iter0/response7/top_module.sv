module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Declare the state variables
reg [1:0] state;

// State definitions
localparam A = 2'b01;
localparam B = 2'b10;

// Asynchronous reset
always @(posedge areset) begin
    state <= A;
    z <= 1'b0;
end

// State transition logic
always @(posedge clk) begin
    case (state)
        A: begin
            if (x) begin
                state <= B;
                z <= 1'b1;
            end else begin
                state <= A;
                z <= 1'b0;
            end
        end
        B: begin
            if (x) begin
                state <= B;
                z <= 1'b0;
            end else begin
                state <= B;
                z <= 1'b1;
            end
        end
        default: begin
            state <= A;
            z <= 1'b0;
        end
    endcase
end

endmodule
