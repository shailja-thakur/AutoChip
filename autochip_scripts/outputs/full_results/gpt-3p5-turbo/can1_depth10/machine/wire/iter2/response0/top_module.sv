module top_module(
    input wire clk,
    input wire rst,
    input wire in,
    output reg out
);
    reg [1:0] state;
    reg [7:0] counter;
    wire [7:0] data_out;
    wire valid_out;

    stimulus_gen stimulus_gen_inst(
        .clk(clk),
        .rst(rst),
        .state(state),
        .counter(counter)
    );

    FSM_fsm_inst(
        .clk(clk),
        .rst(rst),
        .state(state),
        .counter(counter),
        .data_out(data_out),
        .valid_out(valid_out)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            out <= 0;
        end else begin
            if (valid_out) begin
                out <= data_out;
            end
        end
    end

endmodule
