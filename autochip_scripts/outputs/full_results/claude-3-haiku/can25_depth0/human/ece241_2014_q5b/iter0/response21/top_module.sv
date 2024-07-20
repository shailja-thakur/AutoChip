module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// States
parameter A = 2'b01;
parameter B = 2'b10;

// Current state
reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        A: begin
            if (x == 0) begin
                next_state = A;
                z = 0;
            end else begin
                next_state = B;
                z = 1;
            end
        end
        B: begin
            next_state = B;
            z = ~x;
        end
        default: begin
            next_state = A;
            z = 0;
        end
    endcase
end

// Sequential logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

endmodule
