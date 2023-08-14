module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

	// Insert your code below
	
    // Use FSM from Fsm_serial

    // New: Datapath to latch input bits.

    reg [7:0] data_byte;
    reg [1:0] state;
    reg start_bit;
    reg [7:0] data;
    reg stop_bit;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            start_bit <= 1;
            data <= 0;
            stop_bit <= 1;
        end else begin
            case (state)
                0: begin
                    if (in == 1) begin
                        start_bit <= 0;
                        state <= 1;
                    end
                end
                1: begin
                    if (in == 1) begin
                        data <= data + 1;
                    end else begin
                        state <= 2;
                    end
                end
                2: begin
                    if (in == 1) begin
                        data <= data + 1;
                    end else begin
                        state <= 3;
                    end
                end
                3: begin
                    if (in == 1) begin
                        data <= data + 1;
                    end else begin
                        state <= 4;
                    end
                end
                4: begin
                    if (in == 1) begin
                        data <= data + 1;
                    end else begin
                        state <= 5;
                    end
                end
                5: begin
                    if (in == 0) begin
                        state <= 6;
                    end
                end
                6: begin
                    if (in == 0) begin
                        state <= 7;
                    end else begin
                        state <= 0;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 7) begin
            out_byte <= data;
            done <= 1;
        end
    end

endmodule