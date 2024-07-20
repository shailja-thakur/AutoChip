module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// State encoding
parameter A = 1'b0;
parameter B = 1'b1;

// State variables
reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B; // Asynchronously reset to state B
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    // Next state logic
    case (state)
        B: begin
            if (in == 0) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        A: begin
            if (in == 0) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
    endcase
end

// Output logic
assign out = state;

endmodule
