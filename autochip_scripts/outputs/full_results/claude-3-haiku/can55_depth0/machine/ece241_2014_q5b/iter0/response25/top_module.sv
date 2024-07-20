module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
parameter A = 1'b0, B = 1'b1;

// Register to store the current state
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (~x) begin
                    state <= B;
                end
                else begin
                    state <= B;
                end
            end
            default: state <= A;
        endcase
    end
end

// Set the output z based on the current state and input x
always @(*) begin
    if ((state == A && x) || (state == B && ~x)) begin
        z = 1'b1;
    end
    else begin
        z = 1'b0;
    end
end

endmodule
