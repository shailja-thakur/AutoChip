module FSM_fsm (
    input wire clk,
    input wire rst,
    input wire [1:0] state,
    input wire [7:0] counter,
    input wire [7:0] in,
    output reg [7:0] data_out,
    output reg valid_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                2'b10: begin // process state
                    data_out <= in;
                    valid_out <= 1'b0;
                end
                2'b11: begin // done state
                    valid_out <= 1'b1;
                end
                default: begin // idle and wait states
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
            endcase
        end
    end

endmodule
module top_module (
    input wire clk,
    input wire rst,
    input wire in,
    output reg out
);

    wire [1:0] state;
    wire [7:0] counter;
    wire [7:0] data_out;
    wire valid_out;

    FSM_fsm fsm_inst(
        .clk(clk),
        .rst(rst),
        .state(state),
        .counter(counter),
        .in({7'b0, in}), // Added padding bits
        .data_out(data_out),
        .valid_out(valid_out)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 1'b0;
        end else begin
            if (valid_out) begin
                out <= data_out;
            end else begin
                out <= 1'b0; // Added else condition
            end
        end
    end

endmodule
