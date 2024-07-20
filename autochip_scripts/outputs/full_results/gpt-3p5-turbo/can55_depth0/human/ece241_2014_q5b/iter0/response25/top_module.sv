module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    reg z_reg;
    reg [1:0] next_state;

    parameter A = 2'b00;
    parameter B = 2'b01;

    always @(posedge clk or posedge areset) begin
        if (areset) begin // reset state to A
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case(state)
            A: begin
                if (x) begin
                    z_reg = 1'b1;
                    next_state = B;
                end else begin
                    z_reg = 1'b0;
                    next_state = A;
                end
            end
            B: begin
                if (x) begin
                    z_reg = 1'b0;
                    next_state = B;
                end else begin
                    z_reg = 1'b1;
                    next_state = B;
                end
            end
            default: begin
                z_reg = 1'b0;
                next_state = A;
            end
        endcase
    end

    assign z = z_reg;

endmodule
