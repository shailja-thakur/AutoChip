module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
            z <= (state == 2'b10);
        end
    end

    always @(state or x) begin
        case (state)
            2'b00: begin
                if (x == 1'b1)
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
            end
            2'b01: begin
                if (x == 1'b0)
                    next_state = 2'b00;
                else
                    next_state = 2'b10;
            end
            2'b10: begin
                if (x == 1'b1)
                    next_state = 2'b11;
                else
                    next_state = 2'b00;
            end
            2'b11: begin
                next_state = 2'b01;
            end
        endcase
    end
endmodule
