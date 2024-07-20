module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state;
    reg start_shifting;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 0;
        else
            case (state)
                0: if (data) state <= 1; else state <= 0;
                1: if (data) state <= 2; else state <= 0;
                2: if (data) state <= 3; else state <= 0;
                3: if (data) begin
                        state <= 0;
                        start_shifting <= 1;
                    end
                    else
                        state <= 0;
                default: state <= 0;
            endcase
    end

    // The start_shifting signal will stay asserted until reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 0;
    end

endmodule
