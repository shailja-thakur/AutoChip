module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    parameter IDLE = 3'b000, S1 = 3'b001, S11 = 3'b010, S111 = 3'b011, 
              S1111 = 3'b100, S11111 = 3'b101, S111110 = 3'b110, 
              S1111110 = 3'b111;
              
    reg [2:0] state, next_state;

    // State transition
    always @ (posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:       next_state = in ? IDLE : S1;
            S1:         next_state = in ? S11 : S1;
            S11:        next_state = in ? S111 : S1;
            S111:       next_state = in ? S1111 : S1;
            S1111:      next_state = in ? S11111 : S1;
            S11111:     next_state = in ? S111110 : S1;
            S111110:    next_state = in ? S1111110 : S1;
            S1111110:   next_state = in ? S1111110 : S1;
            default:    next_state = IDLE;
        endcase
    end

    // Output logic and error handling
    always @ (posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end 
        else begin
            // Set default outputs
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
            
            case (state)
                S111110: begin
                    if (~in)
                        disc <= 1'b1;
                    else if (in)
                        err <= 1'b1;
                end
                S1111110: begin
                    if (~in)
                        flag <= 1'b1;
                    else if (in)
                        flag <= 1'b1;
                end
                default: ;
            endcase
            
            // Error condition
            if (state == S1111110 && in)
                err <= 1'b1;
        end
    end

endmodule
