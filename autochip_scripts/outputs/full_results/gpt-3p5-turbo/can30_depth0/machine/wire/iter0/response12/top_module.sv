module top_module(
    input clk,
    input reset,
    output reg out
);

    reg [1:0] state;
    reg [7:0] counter;
    wire [7:0] data_out;
    wire valid_out;
    
    // stimulus_gen module instantiation
    stimulus_gen u_stimulus_gen (
        .clk(clk),
        .reset(reset),
        .data_out(data_out),
        .valid_out(valid_out)
    );
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 8'b0;
            out <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // idle state
                    counter <= 8'b0;
                    out <= 1'b0;
                    if (data_out == 8'b0 && valid_out == 1'b0) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin // wait state
                    counter <= counter + 1'b1;
                    out <= 1'b0;
                    if (counter >= 8'd10) begin
                        state <= 2'b10;
                    end else begin
                        state <= 2'b01;
                    end
                end
                2'b10: begin // process state
                    out <= data_out;
                    state <= 2'b11;
                end
                2'b11: begin // done state
                    out <= 1'b1;
                    state <= 2'b00;
                end
            endcase
        end
    end

endmodule
