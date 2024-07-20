module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    reg [7:0] shift_reg;    // shift register to store incoming data bits
    reg [2:0] state;        // FSM state
   
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 8'h00;
            state <= 3'b000;
            done <= 1'b0;
        end else begin
            case (state)
                3'b000: begin  // idle state
                    if (in == 1'b0) begin
                        state <= 3'b001; // start bit detected
                        shift_reg <= 8'h00;
                    end
                end
                3'b001: begin  // receiving data bits
                    shift_reg <= {shift_reg[6:0], in};
                    state <= (state == 3'b100) ? 3'b101 : (state + 1); // check if 8 bits received, if yes go to next state
                end
                3'b010: begin  // waiting for stop bit
                    if (in == 1'b1) begin
                        state <= 3'b011; // stop bit detected
                    end
                end
                3'b011: begin  // verify stop bit
                    if (in == 1'b1) begin
                        done <= 1'b1;   // correct byte received
                        state <= 3'b000; // go back to idle state
                        out_byte <= shift_reg; // assign received byte to output
                    end else begin
                        state <= 3'b010; // start bit detected, wait for stop bit again
                    end
                end
                3'b100: begin  // waiting for next start bit
                    if (in == 1'b0) begin
                        state <= 3'b001; // start bit detected
                        shift_reg <= 8'h00; // reset shift register
                    end
                end
                3'b101: begin  // waiting for stop bit after 8 bits received
                    if (in == 1'b1) begin
                        state <= 3'b011; // stop bit detected
                    end
                end
            endcase
        end
    end
endmodule
