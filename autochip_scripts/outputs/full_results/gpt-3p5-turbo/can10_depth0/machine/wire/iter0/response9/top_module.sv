module top_module(
    input wire clk,
    input wire rst,
    output wire data_out,
    output wire valid_out);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;
    wire tick;

    stimulus_gen stimulus_gen_inst (
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00;
            counter <= 8'b0;
            data <= 8'b0;
            data_out <= 1'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // idle state
                    counter <= 8'b0;
                    data <= 8'b0;
                    data_out <= 1'b0;
                    valid_out <= 1'b0;
                    if (tick) begin
                        state <= 2'b01;
                    end
                end
                2'b01: begin // wait state
                    counter <= counter + 1;
                    data <= 8'b0;
                    data_out <= 1'b0;
                    valid_out <= 1'b0;
                    if (counter == 8'hFF) begin
                        state <= 2'b10;
                    end
                end
                2'b10: begin // process state
                    counter <= 8'b0;
                    data <= in;
                    data_out <= data;
                    valid_out <= 1'b0;
                    state <= 2'b11;
                end
                2'b11: begin // done state
                    counter <= 8'b0;
                    data <= 8'b0;
                    data_out <= data;
                    valid_out <= 1'b1;
                    state <= 2'b00;
                end
            endcase
        end
    end

endmodule
module stimulus_gen(
    input wire clk,
    input wire rst,
    output wire tick);

    reg [7:0] counter;
    reg tick;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 8'b0;
            tick <= 1'b0;
        end else begin
            counter <= counter + 1;
            if (counter == 8'hFF) begin
                counter <= 8'b0;
                tick <= !tick;
            end
        end
    end

endmodule
