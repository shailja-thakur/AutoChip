module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
localparam A = 2'd0;
localparam B = 2'd1;
localparam C = 2'd2;
localparam D = 2'd3;

// Internal register to store the current state
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        // Reset the state to A
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
            end
            C: begin
                if (in) begin
                    state <= D;
                end
                else begin
                    state <= A;
                end
            end
            D: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= C;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end

    // Set the output based on the current state
    out <= (state == D);
end

endmodule
