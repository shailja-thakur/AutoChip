module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    reg [1:0] state, next_state;
    reg [1:0] counter;
    
    localparam A = 2'b00, B = 2'b01, C = 2'b10;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            counter <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == B) begin
                counter <= counter + w;
                if (counter == 2) z <= 1;
                else z <= 0;
            end else begin
                counter <= 0;
                z <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B; 
                else next_state = A;
            end
            B: begin
                if (counter == 3) next_state = A; 
                else next_state = B;
            end
            default: next_state = A;
        endcase
    end
endmodule
