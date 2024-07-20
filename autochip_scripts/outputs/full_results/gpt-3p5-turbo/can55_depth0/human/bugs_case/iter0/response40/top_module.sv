module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid
);


// Declare the 8-bit input code as a wire
wire [7:0] input_code;

// Assign the input to the wire
assign input_code = code;

// Declare the 4-bit output as a wire
wire [3:0] output;

// Declare the 1-bit valid signal as a wire
wire valid_signal;

// Create a small case statement to map the 8-bit input codes to the 4-bit output and the valid signal
always @(*) begin
    case (input_code)
        8'h45: begin
            output = 4'b0000;
            valid_signal = 1'b1;
        end
        8'h16: begin
            output = 4'b0001;
            valid_signal = 1'b1;
        end
        8'h1e: begin
            output = 4'b0010;
            valid_signal = 1'b1;
        end
        8'h26: begin
            output = 4'b0011;
            valid_signal = 1'b1;
        end
        8'h25: begin
            output = 4'b0100;
            valid_signal = 1'b1;
        end
        8'h2e: begin
            output = 4'b0101;
            valid_signal = 1'b1;
        end
        8'h36: begin
            output = 4'b0110;
            valid_signal = 1'b1;
        end
        8'h3d: begin
            output = 4'b0111;
            valid_signal = 1'b1;
        end
        8'h3e: begin
            output = 4'b1000;
            valid_signal = 1'b1;
        end
        8'h46: begin
            output = 4'b1001;
            valid_signal = 1'b1;
        end
        default: begin
            output = 4'b0000;
            valid_signal = 1'b0;
        end
    endcase
end

// Assign the output wire to the output register
assign out = output;
assign valid = valid_signal;

endmodule
