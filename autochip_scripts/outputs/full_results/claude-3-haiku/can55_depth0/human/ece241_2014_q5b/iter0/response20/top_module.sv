module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// One-hot encoding for states
localparam A = 2'b01;
localparam B = 2'b10;

reg [1:0] state, next_state;

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (x) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            if (x) begin
                next_state = B;
            end
            else begin
                next_state = B;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        A: begin
            z = x;
        end
        B: begin
            z = !x;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
