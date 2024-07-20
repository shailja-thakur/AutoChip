module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// Define the states
typedef enum logic [1:0] {
    A,
    B,
    C,
    D
} state_t;

// Define the state register
reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A; // Reset to state A
    end else begin
        case (state)
            A: begin
                if (in) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            B: begin
                if (in) begin
                    state <= C;
                end else begin
                    state <= B;
                end
            end
            C: begin
                if (in) begin
                    state <= D;
                end else begin
                    state <= A;
                end
            end
            D: begin
                if (in) begin
                    state <= B;
                end else begin
                    state <= C;
                end
            end
        endcase
    end
end

// Output logic
always @(state) begin
    out = (state == D) ? 1 : 0;
end

endmodule
