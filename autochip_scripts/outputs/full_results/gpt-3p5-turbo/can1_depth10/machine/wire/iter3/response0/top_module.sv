module stimulus_gen (
    input wire clk,
    input wire rst,
    output reg [1:0] state,
    output reg [7:0] counter
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00;
            counter <= 8'd0;
        end else begin
            case (state)
                2'b00: begin // idle state
                    counter <= 8'd0;
                    state <= 2'b01; // transition to wait state
                end
                2'b01: begin // wait state
                    counter <= counter + 1;
                    if (counter == 8'd10) begin
                        state <= 2'b10; // transition to process state
                    end
                end
                2'b10: begin // process state
                    state <= 2'b11; // transition to done state
                end
                2'b11: begin // done state
                    state <= 2'b00; // transition back to idle state
                end
            endcase
        end
    end

endmodule
module FSM_fsm (
    input wire clk,
    input wire rst,
    input wire [1:0] state,
    input wire [7:0] counter,
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
                    data_out <= in; // Replace "in" with appropriate input signal
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

    stimulus_gen stimulus_gen_inst(
        .clk(clk),
        .rst(rst),
        .state(state),
        .counter(counter)
    );

    FSM_fsm fsm_inst(
        .clk(clk),
        .rst(rst),
        .state(state),
        .counter(counter),
        .data_out(data_out),
        .valid_out(valid_out)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 1'b0;
        end else begin
            if (valid_out) begin
                out <= data_out;
            end
        end
    end

endmodule
