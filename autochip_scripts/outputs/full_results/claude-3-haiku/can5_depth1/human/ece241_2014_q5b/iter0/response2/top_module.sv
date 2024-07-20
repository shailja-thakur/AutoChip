module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// One-hot encoding for the states
localparam A = 2'b01;
localparam B = 2'b10;

// Register to hold the current state
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (x == 1'b0) begin
                next_state = A;
                z = 1'b0;
            end else begin
                next_state = B;
                z = 1'b1;
            end
        end
        B: begin
            next_state = B;
            if (x == 1'b0) begin
                z = 1'b1;
            end else begin
                z = 1'b0;
            end
        end
        default: begin
            next_state = A;
            z = 1'b0;
        end
    endcase
end

// State register update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

endmodule
