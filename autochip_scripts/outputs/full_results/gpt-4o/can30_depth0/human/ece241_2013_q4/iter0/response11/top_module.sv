module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    
    typedef enum reg [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        FULL = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= LOW;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            LOW: begin
                if (s == 3'b001) next_state = MID;
                else if (s == 3'b011) next_state = HIGH;
                else if (s == 3'b111) next_state = FULL;
                else next_state = LOW;
            end
            MID: begin
                if (s == 3'b000) next_state = LOW;
                else if (s == 3'b011) next_state = HIGH;
                else if (s == 3'b111) next_state = FULL;
                else next_state = MID;
            end
            HIGH: begin
                if (s == 3'b000) next_state = LOW;
                else if (s == 3'b001) next_state = MID;
                else if (s == 3'b111) next_state = FULL;
                else next_state = HIGH;
            end
            FULL: begin
                if (s == 3'b000) next_state = LOW;
                else if (s == 3'b001) next_state = MID;
                else if (s == 3'b011) next_state = HIGH;
                else next_state = FULL;
            end
            default: next_state = LOW;
        endcase
    end
    
    always @(*) begin
        case (state)
            LOW: begin
                fr3 = 1;
                fr2 = 1;
                fr1 = 1;
                dfr = 0;
            end
            MID: begin
                fr3 = 0;
                fr2 = 1;
                fr1 = 1;
                dfr = 0;
            end
            HIGH: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 1;
                dfr = 0;
            end
            FULL: begin
                fr3 = 0;
                fr2 = 0;
                fr1 = 0;
                dfr = 0;
            end
        endcase
        
        if (state == LOW && next_state != LOW) dfr = 1;
    end
endmodule
