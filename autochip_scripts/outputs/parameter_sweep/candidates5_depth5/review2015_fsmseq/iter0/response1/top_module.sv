module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [3:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0000;
        else
            state <= next_state;
    end

    always @(state or data) begin
        next_state = state;
        case (state)
            4'b0000: if (data) next_state = 4'b0001;
            4'b0001: if (data) next_state = 4'b0011;
                      else    next_state = 4'b0000;
            4'b0011: if (data) next_state = 4'b0110;
                      else    next_state = 4'b0000;
            4'b0110: if (data) next_state = 4'b1101;
                      else    next_state = 4'b0000;
            4'b1101: if (data) next_state = 4'b0001;
                      else    next_state = 4'b0000;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (state == 4'b1101)
            start_shifting <= 1'b1;
        else
            start_shifting <= 1'b0;
    end

endmodule
