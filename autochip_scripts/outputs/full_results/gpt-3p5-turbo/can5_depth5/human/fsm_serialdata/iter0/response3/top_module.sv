module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg [2:0] count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        data <= 8'b0;
        count <= 3'b0;
        out_byte <= 8'b0;
        done <= 1'b0;
    end else begin
        case(state)
            3'b000: // Idle state
            begin
                if (in == 1'b0) begin
                    state <= 3'b001; // Start bit detected, transition to state 1
                    data <= 8'b0; // Reset data
                    count <= 3'b0; // Reset count
                end
            end
            
            3'b001: // State 1 - Receiving data bits
            begin
                if (count < 3'b000) begin
                    data <= {data[6:0], in}; // Shift in received bit
                    count <= count + 3'b001; // Increment count
                end else begin
                    state <= 3'b010; // Transition to state 2
                    count <= 3'b0; // Reset count
                end
            end
            
            3'b010: // State 2 - Receiving stop bit
            begin
                if (count < 3'b000) begin
                    count <= count + 3'b001; // Increment count
                end else begin
                    if (in == 1'b1) begin
                        out_byte <= data; // Output received byte
                        done <= 1'b1;
                    end
                    state <= 3'b000; // Transition to idle state
                end
            end
        endcase
    end
end
endmodule
