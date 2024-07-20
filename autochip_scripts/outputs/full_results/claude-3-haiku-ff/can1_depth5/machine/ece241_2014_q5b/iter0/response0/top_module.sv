module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the state parameters
localparam A = 1'b0;
localparam B = 1'b1;

// Declare the state register
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
                    state <= A;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

// Assign the output z
always @(*) begin
    if ((state == A && x) || (state == B && ~x)) begin
        z = 1'b1;
    end
    else begin
        z = 1'b0;
    end
end

endmodule
