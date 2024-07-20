module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Parameter definition
parameter A = 0;
parameter B = 1;

// State register
reg [1:0] state;

// Output assignment
assign z = (state == A && x == 1) || (state == B && x == 0);

// State machine logic
always @(posedge clk or posedge areset) begin
    if (areset == 1'b1) begin
        state <= A;
    end else begin
        case (state)
            A: begin
                if (x == 1'b1) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            B: begin
                state <= B;
            end
        endcase
    end
end

endmodule
