module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk, negedge areset) begin
        if (areset == 0)
            state <= 2'b00;
        else
            state <= next_state;
    end

    always @(state, x) begin
        next_state = 2'b00;
        z = 1'b0;

        case (state)
            2'b00: begin
                if (areset == 0)
                    next_state = 2'b00;
                else if (x == 1'b1)
                    next_state = 2'b10;
            end
            2'b10: begin
                next_state = 2'b01;
                z = 1'b1;
            end
            2'b01: begin
                next_state = 2'b01;
                z = 1'b0;
            end
        endcase
    end

endmodule
