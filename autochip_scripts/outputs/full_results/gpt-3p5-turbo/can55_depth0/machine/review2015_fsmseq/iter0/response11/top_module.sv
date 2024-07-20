module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [1:0] state;
    wire next_state_S;
    wire next_state_S1;
    wire next_state_S11;
    wire next_state_S110;
    wire next_state_Done;

    assign next_state_S = (state == 2'b00) && data;
    assign next_state_S1 = (state == 2'b00) && !data || (state == 2'b01) && data;
    assign next_state_S11 = (state == 2'b01) && !data || (state == 2'b10) && data;
    assign next_state_S110 = (state == 2'b10) && !data;
    assign next_state_Done = (state == 2'b10) && data;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else
            case(state)
                2'b00: state <= next_state_S ? 2'b01 : 2'b00;
                2'b01: state <= next_state_S1 ? 2'b10 : 2'b00;
                2'b10: state <= next_state_S11 ? 2'b10 : next_state_S110 ? 2'b11 : 2'b00;
                default: state <= state;
            endcase
    end

    assign start_shifting = (state == 2'b11);

endmodule
