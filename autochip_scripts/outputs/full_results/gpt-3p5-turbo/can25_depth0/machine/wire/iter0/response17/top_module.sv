module top_module(
    input wire clk,
    input wire reset,
    output wire data_out,
    output wire valid_out);

    reg [1:0] state;
    reg [7:0] counter;
    wire clock_edge;
    wire reset_edge;

    stimulus_gen stim_gen(
        .clk(clk),
        .reset(reset),
        .counter(counter),
        .clock_edge(clock_edge),
        .reset_edge(reset_edge)
    );

    always @(posedge clk) begin
        if (reset_edge) begin
            state <= 2'b00;
            counter <= 8'b00000000;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end else begin
            case(state)
                2'b00: begin // idle state
                    counter <= 8'b00000000;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                    if (in == 1'b1) begin
                        state <= 2'b01; // wait state
                    end
                end
                2'b01: begin // wait state
                    counter <= counter + 8'b00000001;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                    if (counter == 8'd255) begin
                        state <= 2'b10; // process state
                    end
                end
                2'b10: begin // process state
                    data_out <= in;
                    state <= 2'b11; // done state
                end
                2'b11: begin // done state
                    valid_out <= 1'b1;
                    if (reset == 1'b1) begin
                        state <= 2'b00; // idle state
                    end
                end
            endcase
        end
    end

endmodule
module stimulus_gen(
    input wire clk,
    input wire reset,
    output wire [7:0] counter,
    output wire clock_edge,
    output wire reset_edge);

    reg clk_prev;
    reg reset_prev;

    always @(posedge clk) begin
        clock_edge <= clk & ~clk_prev;
        clk_prev <= clk;

        reset_edge <= reset & ~reset_prev;
        reset_prev <= reset;

        if (reset_edge) begin
            counter <= 8'b00000000;
        end else if (clock_edge) begin
            counter <= counter + 8'b00000001;
        end
    end

endmodule
