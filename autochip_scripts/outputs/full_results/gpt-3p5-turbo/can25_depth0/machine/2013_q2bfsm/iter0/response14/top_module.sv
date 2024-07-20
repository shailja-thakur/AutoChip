module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [3:0] state;
    wire [1:0] next_state;
    reg [1:0] f_reg;

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= 2'b00; // Starting state: S0
        else
            state <= next_state;
    end

    always @* begin
        case (state)
            2'b00: begin // S0
                if (x)
                    next_state = 2'b01; // S1
                else
                    next_state = 2'b00; // S0
            end
            2'b01: begin // S1
                if (x)
                    next_state = 2'b01; // S1
                else
                    next_state = 2'b10; // S10
            end
            2'b10: begin // S10
                if (x)
                    next_state = 2'b11; // G1
                else
                    next_state = 2'b00; // S0
            end
            2'b11: begin // G1
                if (y)
                    next_state = 2'b10; // P1
                else
                    next_state = 2'b11; // G1
            end
        endcase
    end

    always @(state) begin
        case (state)
            2'b01, 2'b10, 2'b11: f_reg = 2'b01; // f is assigned when the state is B, G1 or G2
            default: f_reg = 2'b00;
        endcase
    end

    assign f = f_reg;

    assign g = (state == 2'b11 || state == 2'b10 || state == 2'b01) ? 1'b1 : 1'b0; // g is assigned when the state is G1 or G2 or P1

endmodule
