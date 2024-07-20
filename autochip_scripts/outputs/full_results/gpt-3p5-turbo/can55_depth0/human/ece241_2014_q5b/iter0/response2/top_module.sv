module top_module (
    input  clk,
    input  areset,
    input  x,
    output z
);

    reg [1:0] state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;

        case (state)
            2'b00: begin
                if (x)
                    next_state = 2'b01;
                z = 1'b0;
            end
            2'b01: begin
                if (x)
                    next_state = 2'b00;
                z = 1'b1;
            end
        endcase
    end

endmodule
