module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // One-hot encoding states
    localparam [1:0] A = 2'b01, B = 2'b10;
    reg [1:0] state, next_state;

    // State transition logic
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
                if (x == 1'b0) begin
                    next_state = B;
                    z = 1'b1;
                end else begin
                    next_state = B;
                    z = 1'b0;
                end
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

endmodule
