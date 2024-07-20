module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [3:0] state;
    reg [3:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 0;
        else
            state <= next_state;
    end

    always @* begin
        case (state)
            0: begin
                if (data)
                    next_state = 1;
                else
                    next_state = 0;
            end
            1: begin
                if (data)
                    next_state = 2;
                else
                    next_state = 0;
            end
            2: begin
                if (data)
                    next_state = 0;
                else
                    next_state = 3;
            end
            3: begin
                if (data)
                    next_state = 3;
                else
                    next_state = 4;
            end
            4: begin
                if (data)
                    next_state = 0;
                else
                    next_state = 1;
            end
            default: next_state = 0;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == 3)
            start_shifting <= 1;
        else
            start_shifting <= start_shifting;
    end

endmodule
