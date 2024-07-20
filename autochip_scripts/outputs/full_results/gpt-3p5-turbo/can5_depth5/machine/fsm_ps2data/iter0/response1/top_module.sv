module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    reg [2:0] state;
    reg [23:0] register;
    wire [2:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end
    
    always @(state or in) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE: begin
                if (in[2] == 0)
                    next_state = BYTE1;
                else
                    next_state = DONE;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if (state == BYTE1)
            register <= {in, register[23:8]};
        else
            register <= register << 8;
    end
    
    assign out_bytes = register;
    assign done = (state == DONE);
    
endmodule
