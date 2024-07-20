module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state;
    wire next_state_done;

    assign start_shifting = (state == 4'b1111);

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0000;
        else
            state <= next_state_done ? 4'b1111 :
                                  (state == 4'b0000 && data) ? 4'b0001 :
                                  (state == 4'b0001 && data) ? 4'b0011 :
                                  (state == 4'b0001 && !data) ? 4'b0000 :
                                  (state == 4'b0011 && data) ? 4'b0011 :
                                  (state == 4'b0011 && !data) ? 4'b0110 :
                                  (state == 4'b0110 && data) ? 4'b1111 :
                                                               4'b0000;
    end

endmodule
