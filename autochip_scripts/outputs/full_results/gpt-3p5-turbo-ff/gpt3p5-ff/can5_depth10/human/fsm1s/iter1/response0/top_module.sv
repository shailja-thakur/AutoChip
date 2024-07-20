module fsm (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state_next;
    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b01;
        end else begin
            state <= state_next;
        end
    end

    always @(*) begin
        case(state)
            2'b00: begin
                if (in)
                    state_next = 2'b01;
                else
                    state_next = 2'b00;
            end
            2'b01: begin
                if (in)
                    state_next = 2'b01;
                else
                    state_next = 2'b10;
            end
            2'b10: begin
                if (in)
                    state_next = 2'b01;
                else
                    state_next = 2'b00;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            out <= 1'b1;
        else begin
            case(state)
                2'b00: out <= 1'b0;
                2'b01: out <= 1'b1;
                2'b10: out <= 1'b0;
            endcase
        end
    end

endmodule
module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    fsm fsm_inst (
        .clk(clk),
        .in(in),
        .reset(reset),
        .out(out)
    );
endmodule
