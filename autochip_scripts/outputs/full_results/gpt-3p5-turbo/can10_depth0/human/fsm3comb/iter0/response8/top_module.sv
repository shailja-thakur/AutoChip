module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    always @(*)
    case(state)
        2'b00: begin // State A
            if (in == 1'b0) begin
                next_state = 2'b00; // Next state is A
                out = 1'b0;
            end
            else begin
                next_state = 2'b01; // Next state is B
                out = 1'b0;
            end
        end
        
        2'b01: begin // State B
            if (in == 1'b0) begin
                next_state = 2'b10; // Next state is C
                out = 1'b0;
            end
            else begin
                next_state = 2'b01; // Next state is B
                out = 1'b0;
            end
        end
        
        2'b10: begin // State C
            if (in == 1'b0) begin
                next_state = 2'b00; // Next state is A
                out = 1'b0;
            end
            else begin
                next_state = 2'b11; // Next state is D
                out = 1'b0;
            end
        end
        
        2'b11: begin // State D
            if (in == 1'b0) begin
                next_state = 2'b10; // Next state is C
                out = 1'b1;
            end
            else begin
                next_state = 2'b01; // Next state is B
                out = 1'b0;
            end
        end
    endcase
    
endmodule
