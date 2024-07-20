module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Output declarations
    wire [9:0] next_state;
    wire out1;
    wire out2;

    // State transition logic
    always @ (in or state) begin
        case (state)
            // State S0
            10'b00000: begin
                if (in == 1'b0) begin
                    next_state = 10'b00000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00001;
                end
                out1 = 1'b0;
                out2 = 1'b0;
            end

            // State S1
            10'b00001: begin
                if (in == 1'b0) begin
                    next_state = 10'b00000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00010;
                end
                out1 = 1'b0;
                out2 = 1'b0;
            end
            
            // State S2
            10'b00010: begin
                if (in == 1'b0) begin
                    next_state = 10'b00000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00011;
                end
                out1 = 1'b0;
                out2 = 1'b0;
            end
            
            // State S3
            10'b00011: begin
                if (in == 1'b0) begin
                    next_state = 10'b00000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00100;
                end
                out1 = 1'b0;
                out2 = 1'b0;
            end
            
            // State S4
            10'b00100: begin
                if (in == 1'b0) begin
                    next_state = 10'b00000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00101;
                end
                out1 = 1'b0;
                out2 = 1'b0;
            end
            
            // State S5
            10'b00101: begin
                if (in == 1'b0) begin
                    next_state = 10'b01000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00110;
                end
                out1 = 1'b0;
                out2 = 1'b0;
            end
            
            // State S6
            10'b00110: begin
                if (in == 1'b0) begin
                    next_state = 10'b10000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00111;
                end
                out1 = 1'b0;
                out2 = 1'b0;
            end
            
            // State S7
            10'b00111: begin
                if (in == 1'b0) begin
                    next_state = 10'b00000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00111;
                end
                out1 = 1'b0;
                out2 = 1'b1;
            end
            
            // State S8
            10'b01000: begin
                if (in == 1'b0) begin
                    next_state = 10'b00000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00001;
                end
                out1 = 1'b1;
                out2 = 1'b0;
            end
            
            // State S9
            10'b10000: begin
                if (in == 1'b0) begin
                    next_state = 10'b00000;
                end else if (in == 1'b1) begin
                    next_state = 10'b00001;
                end
                out1 = 1'b1;
                out2 = 1'b1;
            end
        endcase
    end

endmodule
