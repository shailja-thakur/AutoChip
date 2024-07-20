module top_module (
    input clk,
    input areset,
    input x,
    output z
);

localparam A = 2'b01;
localparam B = 2'b10;

reg [1:0] state, next_state;

// State register
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
assign z = (state == B && !x) || (state == A && x);

endmodule
