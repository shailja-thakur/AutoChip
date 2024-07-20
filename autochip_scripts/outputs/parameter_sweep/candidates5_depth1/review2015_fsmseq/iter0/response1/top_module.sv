module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [3:0] next_state;

    // Declare internal signals
    wire data_match;
    wire reset_sync;

    // Synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= 4'b0000;
        else
            state <= next_state;
    end

    // Synchronous reset generation
    always @(posedge clk or negedge reset) begin
        reset_sync <= reset;
    end

    // Combinational logic for state transitions and data matching
    always @* begin
        next_state = state;
        data_match = (state == 4'b1100 && data) || (state == 4'b1101 && !data);

        case (state)
            4'b0000: if (data == 1) next_state = 4'b0001;
            4'b0001: if (data == 1) next_state = 4'b0010;
            4'b0010: if (data == 0) next_state = 4'b0011;
            4'b0011: if (data == 1) next_state = 4'b1100;
            4'b1100: if (data == 1) next_state = 4'b1101;
            default: next_state = 4'b0000;
        endcase
    end

    // Assign output based on matching state
    always @* begin
        if (state == 4'b1101)
            start_shifting = 1'b1;
        else
            start_shifting = 1'b0;
    end

endmodule
