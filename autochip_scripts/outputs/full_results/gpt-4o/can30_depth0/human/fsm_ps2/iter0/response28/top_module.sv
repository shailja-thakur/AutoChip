module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    reg [1:0] state, next_state;
    reg [1:0] count;

    // State encoding
    localparam WAIT = 2'b00,
               BYTE1 = 2'b01,
               BYTE2 = 2'b10,
               BYTE3 = 2'b11;

    // State transition logic (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT;
            count <= 2'b00;
        end else begin
            state <= next_state;
            if (next_state == BYTE1 || next_state == BYTE2 || next_state == BYTE3)
                count <= count + 1;
            else
                count <= 2'b00;
        end
    end

    // Next state logic (combinational)
    always @(*) begin
        case (state)
            WAIT: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = WAIT;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = WAIT;
            end
            default: next_state = WAIT;
        endcase
    end

    // Output logic
    assign done = (state == BYTE3 && count == 2'b10);

endmodule
